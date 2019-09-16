<template>
    <div id="app">
        <router-link to="/"><md-icon>home</md-icon></router-link>
        <User/>
        <router-view></router-view>
    </div>
</template>

<script>
    import User from './components/User.vue'

    export default {
        name: 'app',
        components: {
            User,
        }
    }
</script>