require 'spec_helper'
describe 'rancher_tools' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end
      if facts[:kernel] == 'Linux' then
        context 'it should handle the cli archive' do
         it do
           is_expected.to contain_archive('/tmp/rancher-linux-amd64-v0.4.1.tar.gz').with(
              'ensure' => 'present',
              'extract' => 'true',
              'extract_path' => '/usr/local/bin',
              'source' => 'https://github.com/rancher/cli/releases/download/v0.4.1/rancher-linux-amd64-v0.4.1.tar.gz',
              'creates' => '/usr/local/bin/rancher'
            )
         end
         it do
           is_expected.to contain_archive('/tmp/rancher-compose-linux-amd64-v0.12.2.tar.gz').with(
            'ensure' => 'present',
            'extract' => 'true',
            'extract_path' => '/usr/local/bin',
            'source' => 'https://github.com/rancher/rancher-compose/releases/download/v0.12.2/rancher-compose-linux-amd64-v0.12.2.tar.gz',
            'creates' => '/usr/local/bin/rancher-compose'
            )
         end
         context 'it should respect the install variables' do
           let(:params){{
            :install_cli => 'false',
            :install_compose => 'false'
            }}
            it do
              should_not contain_archive('/tmp/rancher-linux-amd64-v0.4.1.tar.gz')
            end
         end
        end
      end
    end
  end
end
