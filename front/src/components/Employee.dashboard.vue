<template>
    <div>
        <h1>Employee dashboard</h1>
        <div class="dashboard-employee">
            <md-content><ClockManager/></md-content>
            <md-content></md-content>
            <md-content></md-content>
            <md-content></md-content>
        </div>
    </div>
</template>

<script>
    import ClockManager from "./ClockManager"

    export default {
        components:{
            ClockManager
        }
    }
</script>
<style>
    .dashboard-employee {
        display: flex;
        flex-flow: row wrap;
    }
    .dashboard-employee > .md-content {
        flex:1 1 420px;
        display: flex;
        margin: 5px;
        max-height: 400px;
    }
</style>