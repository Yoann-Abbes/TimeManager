<template>
  <div class="dashboard-general">
    <div v-show="getLoggedUser.status === 'loading'">
      <md-progress-spinner :md-diameter="100" :md-stroke="10" md-mode="indeterminate"></md-progress-spinner>
    </div>
    <div v-show="getLoggedUser.status === 'success'">
      <employee v-show="getLoggedUser.role === 1"/>
      <manager v-show="getLoggedUser.role === 2"/>
      <general v-show="getLoggedUser.role === 3"/>
    </div>
  </div>
</template>

<script>
  import employee from './Employee.dashboard'
  import manager from './Manager.dashboard'
  import general from './General_Manager.dashboard'

  export default {
    components:{
      employee,
      manager,
      general
    },
    computed: {
      getLoggedUser(){
        return this.$store.getters['userModule/getLoggedUser']
      }
    }
  }
</script>
