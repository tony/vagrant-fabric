require "vagrant-fabric/config"
require 'rspec/its'

describe VagrantPlugins::Fabric::Config do
  let(:instance) { described_class.new }

  # Ensure tests are not affected by AWS credential environment variables
  before :each do
    ENV.stub(:[] => nil)
  end

  describe "defaults" do
    subject do
      instance.tap do |o|
        o.finalize!
      end
    end

    its("fabfile_path")     { should == "fabfile.py" }
    its("fabric_path")     { should == "fab" }
    its("python_path")     { should == "python" }
    its("tasks")     { should == [] }
    its("remote")     { should be false }
    its("remote_install")     { should be false }
    its("remote_password")     { should == "vagrant" }
    its("remote_current_dir")     { should == "." }
  end
end
