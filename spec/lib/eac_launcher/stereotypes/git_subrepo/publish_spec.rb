# frozen_string_literal: true

require 'eac_launcher/stereotypes/git_subrepo/publish'

RSpec.describe EacLauncher::Stereotypes::GitSubrepo::Publish do
  describe '#check' do
    context 'on clean context' do
      let(:settings_path) { ::File.join(__dir__, 'publish_spec_settings.yml') }

      before do
        temp_context(settings_path)
      end

      context 'on app with subrepo' do
        let(:remote_repos) { init_remote('mylib') }

        before do
          wc = init_git('mylib')
          touch_commit(wc, 'file1')
          wc.execute!('remote', 'add', 'publish', remote_repos)
          wc.execute!('push', 'publish', 'master')
        end

        let!(:app) do
          r = init_git('app')
          touch_commit(r, 'file2')
          r.execute!('subrepo', 'clone', remote_repos, 'mylib')
          r
        end

        it { check_publish_status(:updated) }

        context 'after subrepo updated and before publishing' do
          before do
            ::EacLauncher::Context.current.publish_options[:confirm] = true
            touch_commit(app, 'mylib/file3')
          end

          it { expect(::EacLauncher::Context.current.publish_options[:confirm]).to eq(true) }
          it { check_publish_status(:pending) }

          context 'after publishing' do
            before { described_class.new(app_mylib_instance).run }

            it { check_publish_status(:updated) }

            context 'after reset context' do
              before do
                sleep 2
                ::EacLauncher::Context.current = ::EacLauncher::Context.new(
                  projects_root: ::EacLauncher::Context.current.root.real,
                  settings_file: settings_path,
                  cache_root: ::Dir.mktmpdir
                )
              end

              it { check_publish_status(:updated) }
            end
          end
        end

        def check_publish_status(status_key)
          instance = app_mylib_instance
          expect(instance).to be_a(::EacLauncher::Instances::Base)
          expect(instance.stereotypes).to include(::EacLauncher::Stereotypes::GitSubrepo)

          status = ::EacLauncher::Publish::CheckResult.const_get("STATUS_#{status_key}".upcase)
          publish = described_class.new(instance)
          expect(publish.check.status).to eq(status), "Expected: #{status}, Actual: " \
            "#{publish.check.status}, Message: #{publish.check.message}"
        end

        def app_mylib_instance
          ::EacLauncher::Context.current.instance('/app/mylib')
        end
      end
    end
  end
end
