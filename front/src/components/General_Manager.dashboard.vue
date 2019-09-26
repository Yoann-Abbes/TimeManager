<template>
    <div>
        <h1>General Manager dashboard</h1>
        <div class="dashboard">
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