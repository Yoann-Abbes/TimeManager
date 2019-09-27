<template>
    <div>
        <h1>Manager dashboard</h1>
        <div class="dashboard">
            <md-content><ClockManager/></md-content>
            <md-content></md-content>
            <md-content></md-content>
            <md-content class="no-p" ><WorkingTimes/></md-content>
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
        }
    }
</script>