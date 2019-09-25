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
          >Wrong password or username, please try again</div>
          <form @submit.prevent="login">
            <md-field>
              <label>Username</label>
              <md-input type="text" required autofocus v-model="loginForm.username"></md-input>
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
        username: "",
        password: ""
      }
    };
  },
  computed: {
    getLoginStatus() {
      return this.$store.getters["authModule/getStatus"];
    }
  },
  methods: {
    login: function() {
      const { username, password } = this.loginForm;
      this.$store
        .dispatch("authModule/login", {
          username: username,
          password: password
        })
        .then(success => {
          this.$router.push("/dashboard");
        });
    }
  }
};
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
