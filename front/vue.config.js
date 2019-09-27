const webpack = require('webpack')
module.exports = {
    devServer: {
        proxy: {
            '^/api/*': {
                target: "http://3.19.241.63:4000",
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