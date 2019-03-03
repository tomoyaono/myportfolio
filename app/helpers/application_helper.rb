module ApplicationHelper
  def default_meta_tags
    {
      og: {
        site_name: 'TomoyaOno|大野智也|Portfolio', # もしくは site_name: :site
        title: 'My Portfolio', # もしくは title: :title
        description: 'Finally, I created my website!! I hope you enjoy watching my artworks.|ポートフォリオサイト作りました！興味ある方は是非見て下さい。', # もしくは description: :description
        type: 'website',
        url: request.original_url,
        image: image_url('http://tomoyaono.com/assets/screenshot.png'),
      },
      twitter: {
        card: 'summary large image',
        site: '@art_abroad_tom',
      }
    }
  end
end
