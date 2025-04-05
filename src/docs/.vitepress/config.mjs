import { defineConfig } from 'vitepress'

export default defineConfig({
  title: 'Laravel 12 Sandbox',
  description: 'Laravel 12 Sandbox Documentation',
  themeConfig: {
    nav: [
      { text: 'Home', link: '/' },
      { text: 'Setup', link: '/setup' },
      { text: 'Architecture', link: '/architecture' },
      { text: 'API', link: '/api' },
      { text: 'Guidelines', link: '/guidelines' }
    ],
    sidebar: [
      {
        text: 'Guide',
        items: [
          { text: 'Setup', link: '/setup' },
          { text: 'Architecture', link: '/architecture' },
          { text: 'API Reference', link: '/api' },
          { text: 'Guidelines', link: '/guidelines' }
        ]
      }
    ],
    socialLinks: [
      { icon: 'github', link: 'https://github.com/jaganoer-works/laravel12-sandbox' }
    ]
  }
}) 