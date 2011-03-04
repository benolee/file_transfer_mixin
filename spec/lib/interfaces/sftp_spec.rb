require 'spec_helper'

describe ::FileTransferMixin::Interfaces::SFTP do
  before(:each) do
    Object.send(:remove_const, :TestFileTransferMixin) if defined?(TestFileTransferMixin)
    ENV['FILE_TRANSFER_MIXIN_CONFIG_PATH'] = '/tmp/file_transfer_mixin_enviro_config.yml'
    ENV['ENVY_ENV'] = 'development'

    @config = {
      :development => {
        :sftp => {
          :some_key => {
            :server => '127.0.0.1',
            :username => 'user',
            :password => 'pass',
          }
        }
      },
      :test => {
      },
      :production => {
      },
    }
    File.open(ENV['FILE_TRANSFER_MIXIN_CONFIG_PATH'], 'w') do |f|
      f.write(YAML.dump(@config))
    end

    class TestFileTransferMixin
      include FileTransferMixin
    end

    sftp_mock = mock('sftp')
    sftp_mock.stub!(:upload!).and_return(true)
    sftp_mock.stub!(:download!).and_return(true)
    Net::SFTP.stub(:start).and_return(sftp_mock)
  end

  it "should know its parent configuration key" do
    subject.configuration.should == @config[:development][:sftp]
  end

  it "should be able to find the server, username, and password for a given key" do
    subject.configuration[:some_key][:server].should == '127.0.0.1'
    subject.configuration[:some_key][:username].should == 'user'
    subject.configuration[:some_key][:password].should == 'pass'
  end

  it "should respond to sftp_send" do
    lambda{ TestFileTransferMixin.new.sftp_send(:some_key, 'path', 'file_path') }.should_not raise_error
  end

  it "should respond to sftp_fetch" do
    lambda{ TestFileTransferMixin.new.sftp_fetch(:some_key, 'path', 'file_path') }.should_not raise_error
  end
end
