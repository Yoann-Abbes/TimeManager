const webpack = require('webpack')
module.exports = {
    devServer: {
        proxy: {
            '^/api/*': {
                target: "http://localhost:4000",
                ws: true,
                changeOrigin: true,
            },
        }
    },
    configureWebpack: {
        plugins: [
            new webpack.ProvidePlugin({ jQuery: 'jquery', }),
        ]
    }
}