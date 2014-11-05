require 'nokogiri'
require 'open-uri'
require 'fileutils'
require 'tmpdir'
require 'zipruby'

BASE_URL = 'http://www.post.japanpost.jp/zipcode/dl/'

@ticker_code_list = {
    'ken_all' => 'kogaki/zip/ken_all.zip',
    # 'ken_all_rome' => 'roman/ken_all_rome.zip',
}

tmp_dir = Dir.mktmpdir('zip_')

@ticker_code_list.each do |key, value|

  save_file_name = "#{tmp_dir}/#{key}.zip"
  output_file_name = "#{tmp_dir}/output"

  p save_file_name

  open(save_file_name, 'wb') do |output|
    open("#{BASE_URL}#{value}") do |data|
      output.write(data.read)
    end
  end

  Zip::Archive.open(save_file_name) do |archives|
    archives.each do |a|
      unless a.directory?
        File.open(a.name, "w+b") do |f|
          f.print(a.read)
        end
      end
    end
  end

end
