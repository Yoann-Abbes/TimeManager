<template>
    <div>
        <h1>Manager dashboard</h1>
        <div class="dashboard">
            <md-content><ClockManager :user="user"/></md-content>
            <md-content>
            <router-link :to="{ name: 'dashboard.dialog', params: {userId: 4}}">
                <md-icon>edit</md-icon>
            </router-link>
            </md-content>
            <md-content></md-content>
            <md-content class="no-p" ><WorkingTimes :user="user"/></md-content>
        </div>
    </div>
</template>

<script>
    import ClockManager from "./ClockManager"
    import WorkingTimes from "./WorkingTimes"

    export default {
        components:{
            ClockManager,
            WorkingTimes
        },
        props: ['user']
    }
</script>