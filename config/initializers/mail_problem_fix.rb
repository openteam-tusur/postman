# may be fix "NameError: uninitialized constant Mail::Parsers::ContentTransferEncodingParser"

Mail.eager_autoload! if Rails.env.production? && defined?(Mail)
