<template>
    <div>
        <h1>General Manager dashboard</h1>
        <div class="dashboard">
            <md-content><ClockManager :user="user"/></md-content>
            <md-content></md-content>
            <md-content></md-content>
            <md-content class="no-p" ><WorkingTimes :user="user"/></md-content>
            <md-content class="no-p" ><ChartManager :user="user"/></md-content>
        </div>
    </div>
</template>

<script>
    import ClockManager from "./ClockManager"
    import WorkingTimes from "./WorkingTimes"
    import ChartManager from "./ChartManager"

    export default {
        components:{
            WorkingTimes,
            ClockManager,
            ChartManager
        },
        props: ['user']
    }
</script>