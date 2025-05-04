require 'open-uri'
require 'fileutils'

module ReverseMarkdown
  module Converters
    class ImgDownload < Base
      def convert(node, state = {})
        alt   = node['alt']
        src   = node['src']
        title = extract_title(node)
        url = ReverseMarkdown::Converters::ImgDownload.download_image(src)
        url ? " ![#{alt}](#{url}#{title})" : ''
      end

      def self.download_image(url)
        save_dir = 'tmp/md/images'

        # Создаем директорию, если её нет
        FileUtils.mkdir_p(save_dir) unless Dir.exist?(save_dir)

        # Извлекаем имя файла из URL
        filename = File.basename(url)

        # Полный путь для сохранения
        full_path = File.join(save_dir, filename)

        unless File.exist?(full_path)
          # Скачиваем и сохраняем файл
          URI.open(url) do |image|
            File.open(full_path, 'wb') do |file|
              file.write(image.read)
            end
          end
        end

        "../images/#{filename}"
      rescue => e
        puts "Ошибка при загрузке изображения: #{e.message}"
        nil
      end
    end
  end
end
