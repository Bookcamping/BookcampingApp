if defined?(HoptoadNotifier)
  HoptoadNotifier.configure do |config|
    config.api_key     = '13e5267cb7993c7d9ef0a573a44d8239'
    config.host        = 'errcamping.herokuapp.com'
    config.port        = 80
    config.secure      = config.port == 443
  end
end
