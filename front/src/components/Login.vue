<template>
  <div class="login">
    <div class="centered-container">
      <md-content class="md-elevation-3">
        <div class="title">
          <div class="md-title">Please connect with your personal account</div>
        </div>
        <div class="form">
          <div
            class="error"
            v-show="getLoginStatus == 'error'"
          >Wrong password or email, please try again</div>
          <form @submit.prevent="login">
            <md-field>
              <label>E-mail</label>
              <md-input type="email" required autofocus v-model="loginForm.email"></md-input>
            </md-field>
            <md-field md-has-password>
              <label>Password</label>
              <md-input required v-model="loginForm.password" type="password"></md-input>
            </md-field>
            <div class="actions md-layout md-alignment-center-space-between">
              <md-button class="md-raised md-primary" type="submit">Log in</md-button>
            </div>
          </form>
        </div>
      </md-content>
      <div class="background" />
    </div>
  </div>
</template>

<script>

  export default {
    data() {
      return {
        loginForm: {
          email: "",
          password: ""
        }
      }
    },
    methods: {
      login: function() {
        const { email, password } = this.loginForm;
        this.$store.dispatch("authModule/login", {
          email: email,
          password: password
        }).then(
          success => {
            this.$router.push('/home')
          }
        )
      }
    }
  }
</script>

<style>
  .centered-container {
    display: flex;
    align-items: center;
    justify-content: center;
    position: relative;
    height: 100vh;
  }
  .title {
    text-align: center;
    margin-bottom: 30px;
  }
  .form {
    margin-bottom: 60px;
  }
  .md-content {
    padding: 40px;
  }
</style>
