actions :register, :deregister
default_action :register
state_attrs :aws_access_key,
            :name

attribute :aws_access_key,        kind_of: String
attribute :aws_secret_access_key, kind_of: String
attribute :aws_session_token,     kind_of: String, default: nil
attribute :aws_assume_role_arn,   kind_of: String
attribute :aws_role_session_name, kind_of: String
attribute :name,                  kind_of: String
