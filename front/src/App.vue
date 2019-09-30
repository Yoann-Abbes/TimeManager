<template>
  <div id="app">
    <md-toolbar class="md-primary" md-elevation="1">
      <h3 class="md-title" style="flex: 1">Gotham</h3>
      <router-link to="/dashboard">
        <md-button>
          <md-icon>dashboard</md-icon>
          <md-tooltip>Dashboard</md-tooltip>
        </md-button>
      </router-link>
        <router-link  to="/register" v-show="getLoggedUser.role === 2">
          <md-button>
            <md-icon>person_add</md-icon>
            <md-tooltip>Add employee</md-tooltip>
          </md-button>
        </router-link>
      <router-link  to="/register" v-show="getLoggedUser.role === 3">
          <md-button>
            <md-icon>person_add</md-icon>
            <md-tooltip>Add employee and manager</md-tooltip>
          </md-button>
        </router-link>
      <router-link to="/profile"  v-show="getLoginStatus === 'success'">
        <md-button>
          <md-icon>assignment_ind</md-icon>
          <md-tooltip>Profile</md-tooltip>
        </md-button>
      </router-link>
      <md-button v-show="getLoginStatus === 'success'" @click.prevent="logout">
        <md-icon>exit_to_app</md-icon>
        <md-tooltip>Logout</md-tooltip>
      </md-button>
    </md-toolbar>
    <div style="padding:20px">
      <router-view></router-view>
    </div>
  </div>
</template>

<script>
  export default {
    computed: {
      getLoggedUser(){
        return this.$store.getters['userModule/getLoggedUser']
      },
      getLoginStatus(){
        return this.$store.getters['authModule/getStatus']
      }
    },
    methods: {
      logout(){
        this.$store.dispatch('authModule/logout')
      }
    }
  }
</script>