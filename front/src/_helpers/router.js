import Vue from 'vue'
import Router from 'vue-router'
import store from '../_store'
import Dashboard from "../components/Dashboard";
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
            component: Register,
        },
        {
            path: '/',
            alias: '/dashboard',
            name: 'dashboard',
            component: Dashboard
        },
        {
            path: '/*',
            redirect: { name: 'dashboard' }
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