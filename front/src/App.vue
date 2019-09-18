<template>
    <div id="app">
        <md-toolbar class="md-primary" md-elevation="1">
            <h3 class="md-title" style="flex: 1">Gotham </h3>
            <router-link to="/"><md-button><md-icon>home</md-icon></md-button></router-link>
        </md-toolbar>
        <div style="padding:20px">
            <User/>
            <router-view></router-view>
        </div>
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