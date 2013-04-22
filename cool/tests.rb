$: << '.'
Dir.glob('cool/tests/**/*Test.rb').each do |f| require f end

