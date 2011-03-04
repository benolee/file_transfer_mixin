module FileTransferMixin
  module InstanceMethods
    extend Forwardable

    def_delegators :file_transfer_mixin_sftp_instance, :sftp_send, :sftp_fetch

    private
    def file_transfer_mixin_sftp_instance
      ::FileTransferMixin::Interfaces::SFTP.new
    end
  end

  module Interfaces
    class SFTP
      def configuration
        FileTransferMixin.configuration.sftp
      end

      def sftp_block(key, &block)
        Net::SFTP.start(configuration[key][:server], configuration[key][:username], :password => configuration[key][:password]) do |sftp|
          yield(sftp)
        end
      end

      def sftp_send(key, remote_path, local_path)
        sftp_block(key) do |sftp|
          sftp.upload!(local_path, remote_path)
        end
      end

      def sftp_fetch(key, remote_path, local_path)
        sftp_block(key) do |sftp|
          sftp.download!(remote_path, local_path)
        end
      end
    end
  end
end
