require 'spec_helper'

describe FileTransferMixin do
  before(:each) do
    ENV['FILE_TRANSFER_MIXIN_CONFIG_PATH'] = '/tmp/file_transfer_mixin_enviro_config.yml'

    config = {
      :development => {
      },
      :test => {
      },
      :production => {
      },
    }
    File.open(ENV['FILE_TRANSFER_MIXIN_CONFIG_PATH'], 'w') do |f|
      f.write(YAML.dump(config))
    end
  end

  it "should be valid" do
    FileTransferMixin.should be_a(Module)
  end

  it "should know where to find its configuration file" do
    FileTransferMixin.configuration_path.should == ENV['FILE_TRANSFER_MIXIN_CONFIG_PATH']
  end
end
