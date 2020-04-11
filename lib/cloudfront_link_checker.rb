class CloudfrontLinkChecker
  def self.scan_files(directory_to_scan)
    Dir.chdir(directory_to_scan) do
      system('pwd')
      htmlfiles = File.join("**", "*.html")
      files = Dir.glob(htmlfiles)
      bad_files = {}
      files.each do |file|
        bad_links = []
        results = File.readlines(file, :encoding => "UTF-8").grep /href="(.*)"/i
        results.each do |line|
          links = line.match(/href=(["'])(.*?)\1/i)[2]
          exclude_start_with_list = ["https:", "http:", "#", "mailto:", "tel:"]
          exclude_endings = [".ico", ".png", ".css", "/#contact-us", ".pdf", ".html"]
          if !links.start_with?(*exclude_start_with_list) && !links.end_with?(*exclude_endings)
            if !links.start_with?("/") || !links.end_with?("/")
              bad_links.push(links)
            end
          end
        end
        # Add the bad files to a map keyed of filename
        if !bad_links.empty?
          bad_files[file] = bad_links
        end
      end

      if !bad_files.empty?
        raise "Bad links discovered. Links need to start and end with forward-slashs to be served by CloudFront: #{bad_files}"
      end
    end
  end
end
