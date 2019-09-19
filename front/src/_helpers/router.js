import Vue from 'vue'
import Router from 'vue-router'
import Home from "../components/Home";
import WorkingTimes from "../components/WorkingTimes";
import WorkingTime from "../components/WorkingTime";
import ClockManager from "../components/ClockManager";
import ChartManager from "../components/ChartManager";
import Register from "../components/Register";
import Login from "../components/Login";

Vue.use(Router)

const router = new Router({
    mode: 'history',
    base: process.env.BASE_URL,
    routes: [{
            path: '/workingtimes/:userId?',
            name: 'workingTimes',
            component: WorkingTimes,
            children: [{
                path: '/workingtime/:userId?/:workingtimeId?',
                name: 'workingTime.dialog',
                components: {
                    default: WorkingTime
                }
            }]
        },
        {
            path: '/clock/:username?',
            name: 'clockManager',
            component: ClockManager
        },
        {
            path: '/chartManager/:userId?',
            name: 'chartManager',
            component: ChartManager
        },
        {
            path: '/register',
            name: 'register',
            component: Register
        },
        {
            path: '/home',
            //alias: '/home',
            name: 'home',
            component: Register
        },
        {
            path: '/*',
            redirect: { name: 'home' }
        }
    ]
})
export default router;