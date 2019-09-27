<template>
    <div>
        <div v-if="$route.params.userId">
            <router-link to="/dashboard">&lt;&lt; Back</router-link>
        </div>
        <h1>{{ ($route.params.userId) ? user.firstname + ' ' + user.lastname + ' Dashboard' : 'Employee Dashboard'}}</h1>
        <div class="dashboard">
            <md-content><ClockManager :user="user"/></md-content>
            <md-content></md-content>
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
<style>


</style>