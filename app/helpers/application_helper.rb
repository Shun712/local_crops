module ApplicationHelper
  def default_meta_tags
    {
      site: Settings.meta.site,
      reverse: true,
      title: Settings.meta.title,
      description: Settings.meta.description,
      keywords: Settings.meta.keywords,
      canonical: request.original_url,
      icon: [
        { href: image_url('favicon.ico') }
      ],
      og: {
        title: :full_title,
        description: :description,
        type: Settings.meta.og.type,
        url: request.original_url,
        image: image_url(Settings.meta.og.image_path),
        locale: 'ja_JP',
      },
      twitter: {
        card: 'summary_large_image'
      },
    }
  end
end
