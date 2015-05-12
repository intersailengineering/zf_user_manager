module ZfUserManager
  class Engine < ::Rails::Engine
    isolate_namespace ZfUserManager

    # Load host application decorators to override classes
    config.to_prepare do
      Dir.glob(Rails.root + "app/decorators/**/*_decorator*.rb").each do |file|
        require_dependency(file)
      end
    end
  end
end
