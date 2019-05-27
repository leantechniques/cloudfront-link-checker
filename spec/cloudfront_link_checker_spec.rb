require 'cloudfront_link_checker'

RSpec.describe CloudfrontLinkChecker do
  context "inspects hrefs for bad Cloudfront links" do
    it "allow pdf files" do
      allow(Dir).to receive(:chdir) { |&block| block.call() }
      allow(Dir).to receive(:glob).and_return(["somefile.html"])
      allow(File).to receive(:readlines).and_return(['<a href="/some.pdf">Link to PDF</a>'])
      allow(File).to receive(:readlines).and_return(['<a href="/community/2019/05/22/kcdc.html">html Link</a>'])

      expect(CloudfrontLinkChecker.scan_files('app/_site')).to be_nil
    end
  end
end
