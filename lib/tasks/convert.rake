namespace :convert do
  task md: :environment do
    ReverseMarkdown.config do |config|
      config.github_flavored  = true
    end

    ReverseMarkdown::Converters.register :img, ReverseMarkdown::Converters::ImgDownload.new

    Livestreet::Topic.find_each do |topic|
      next unless topic.topic_publish > 0

      header = "# #{topic.topic_title}\n\n"
      header += "Дата создания: #{topic.topic_date_add.strftime('%F')}\n\n"
      header += "Автор: #{topic.user&.user_login}\n\n" if topic.user
      header += "Теги: #{topic.topic_tags}\n\n" if topic.topic_tags.present?

      photos = topic.photos.map do |photo|
        puts "#{photo.path} - #{photo.description}"
        url = ReverseMarkdown::Converters::ImgDownload.download_image(photo.path)
        next unless url

        " ![#{photo.description}](#{url})"
      end.compact.join("\n\n")

      md_content = header + photos + ReverseMarkdown.convert(topic.content&.topic_text)
      filename = "#{topic.topic_date_add&.strftime('%F')} - #{topic.topic_title}.md"
      filename = ActiveStorage::Filename.new(filename).sanitized
      directory = topic.blog.blog_title
      FileUtils.mkdir_p("tmp/md/#{directory}")
      File.write("tmp/md/#{directory}/#{filename}", md_content)
    end
  end
end
