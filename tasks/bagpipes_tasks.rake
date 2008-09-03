namespace :bagpipes do
  task :load_rails do
    unless Kernel.const_defined?('RAILS_ROOT')
      Kernel.const_set('RAILS_ROOT', File.join(File.dirname(__FILE__), '..', '..', '..'))
    end

    if (File.exists?(RAILS_ROOT) && File.exists?(File.join(RAILS_ROOT, 'app')))
      require "#{RAILS_ROOT}/config/boot"
      require "#{RAILS_ROOT}/config/environment"
      require 'rails_generator'
      require 'rails_generator/scripts/generate'
    end    
  end

  desc "Installs Bagpipes"
  task :install => :load_rails do
    Rails::Generator::Scripts::Generate.new.run(['bagpipes'])
  end
  
end

