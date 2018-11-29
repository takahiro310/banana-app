module ApplicationHelper
    def default_meta_tags
        {
            site: 'Asfors -連想ゲーム-',
            reverse: true,
            charset: 'utf-8',
            description: '連想ゲームをお楽しみください',
            icon: image_url("/favicon.ico"),
            canonical: request.original_url,
            separator: '|',
            og: {
                site_name: 'Asfors -連想ゲーム-',
                description: '連想ゲームをお楽しみください',
                type: 'website',
                url: request.original_url,
                image: image_url('/image/ogp.png'),
                locale: 'ja_JP',
            },
            twitter: {
                card: 'summary',
                site: '@takahiro310',
            }
        }
    end
end
