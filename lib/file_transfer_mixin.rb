require 'enviro'
require 'net/sftp'

module FileTransferMixin
  include ::Enviro::Environate
  configuration_path_env :file_transfer_mixin_config_path
end
