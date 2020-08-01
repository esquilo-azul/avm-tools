# frozen_string_literal: true

require 'eac_launcher/context'

RSpec.describe ::EacLauncher::Context do
  describe '#instances' do
    it 'returns all stub instances' do
      is = described_class.current.instances.map(&:name)
      expect(is).to contain_exactly('/eac_launcher_stub', '/ruby_gem_stub')
    end
  end

  describe '#instance' do
    it 'returns with slash on begin' do
      expect(described_class.current.instance('/eac_launcher_stub'))
        .to be_a(::Avm::Launcher::Instances::Base)
    end

    context 'subinstance mylib' do
      before do
        temp_context(::File.join(__dir__, 'context_spec.yml'))

        @repos = init_remote('mylib_repos')

        wc = init_git('mylib_wc')
        touch_commit(wc, 'init.rb')
        wc.execute!('remote', 'add', 'origin', @repos)
        wc.execute!('push', 'origin', 'master')
      end

      it 'recovers recursive subinstance GitSubrepo' do
        app = init_git('app')
        touch_commit(app, 'sub1/init.rb')
        app.execute!('subrepo', 'clone', @repos, 'sub1/mylib')
        sub = described_class.current.instance('/app/sub1')
        expect(sub).to be_a(::Avm::Launcher::Instances::Base)
        ::Avm::Projects::Stereotype.git_stereotypes.each do |s|
          expect(sub.stereotypes).not_to include(s)
        end
        instance = described_class.current.instance('/app/sub1/mylib')
        expect(instance).to be_a(::Avm::Launcher::Instances::Base)
        expect(instance.stereotypes).to include(::Avm::Projects::Stereotypes::GitSubrepo)
      end

      it 'recovers recursive subinstance GitSubtree' do
        app = init_git('app')
        touch_commit(app, 'sub1/init.rb')
        app.execute!('subtree', 'add', '-P', 'sub1/mylib', @repos, 'master')
        app.execute!('remote', 'add', 'mylib', @repos)
        sub = described_class.current.instance('/app/sub1')
        expect(sub).to be_a(::Avm::Launcher::Instances::Base)
        ::Avm::Projects::Stereotype.git_stereotypes.each do |s|
          expect(sub.stereotypes).not_to include(s)
        end
        instance = described_class.current.instance('/app/sub1/mylib')
        expect(instance).to be_a(::Avm::Launcher::Instances::Base)
        expect(instance.stereotypes).to include(::Avm::Projects::Stereotypes::GitSubtree)
      end

      context 'subtree present' do
        before do
          @app = init_git('subtree_main_app')
          touch_commit(@app, 'file1')
          @app.execute!('subtree', 'add', '-P', 'mylib', @repos, 'master')
          @app.execute!('remote', 'add', 'mylib', @repos)
        end

        it 'recognizes subtree instance' do
          i = described_class.current.instance('/subtree_main_app/mylib')
          expect(i).to be_a(::Avm::Launcher::Instances::Base)
          expect(i.stereotypes).to include(::Avm::Projects::Stereotypes::GitSubtree)
        end
      end

      context 'subinstance in HEAD and not in git_current_revision' do
        it 'does not return subinstance' do
          app = init_git('app') # HEAD: master
          touch_commit(app, 'file2')
          app.execute!('checkout', '-b', 'not_master') # HEAD: not_master
          app.execute!('subrepo', 'clone', @repos, 'mylib')
          expect(described_class.current.instance('/app/mylib')).to be_nil
        end
      end

      context 'subinstances in/not in HEAD and not in/in git_current_revision' do
        context 'subinstance in HEAD and not in git_current_revision' do
          it 'does not return subinstance' do
            app = init_git('app') # HEAD: master
            touch_commit(app, 'file2')
            app.execute!('checkout', '-b', 'not_master') # HEAD: not_master
            app.execute!('subrepo', 'clone', @repos, 'mylib')
            expect(described_class.current.instance('/app/mylib')).to be_nil
          end
        end

        context 'subinstance not in HEAD and in git_current_revision' do
          it 'returns subinstance' do
            app = init_git('app') # HEAD: master
            touch_commit(app, 'file3')
            app.execute!('branch', '-f', 'not_master')
            app.execute!('subrepo', 'clone', @repos, 'mylib')
            app.execute!('checkout', 'not_master') # HEAD: not_master
            expect(described_class.current.instance('/app/mylib'))
              .to be_a(::Avm::Launcher::Instances::Base)
          end
        end
      end
    end
  end
end
