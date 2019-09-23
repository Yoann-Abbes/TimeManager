import Vue from 'vue'
import Router from 'vue-router'
import Home from "../components/Home";
import Register from "../components/Register";
import Login from "../components/Login";

Vue.use(Router)

const router = new Router({
    mode: 'history',
    base: process.env.BASE_URL,
    routes: [
        {
            path: '/login',
            name: 'login',
            component: Login
        },
        {
            path: '/register',
            name: 'register',
            component: Register
        },
        {
            path: '/',
            alias: '/home',
            name: 'home',
            component: Home
        },
        {
            path: '/*',
            redirect: { name: 'home' }
        }
    ]
})

router.beforeEach((to, from, next) => {
    // redirect to login page if not logged in and trying to access a restricted page
    const publicPages = ['/login'];
    const authRequired = !publicPages.includes(to.path);
    const loggedIn = localStorage.getItem('user');

    if (authRequired && !loggedIn) {
        return next('/login');
    }


    next();
})
export default router;