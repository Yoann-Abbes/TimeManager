<template>
  <div class="register">
    <div class="centered-container">
      <md-content class="md-elevation-3">
        <div class="title">
          <div class="md-title">Add person</div>
        </div>

        <div class="form">
          <div
                  class="error"
                  v-show="getRegisterStatus == 'error'"
          >Error during your account creation, please try again</div>
          <form @submit.prevent="register">
            <md-field>
              <label>Username</label>
              <md-input required v-model="registerForm.username"></md-input>
            </md-field>
            <md-field>
              <label>Firstname</label>
              <md-input required v-model="registerForm.firstname"></md-input>
            </md-field>
            <md-field>
              <label>Lastname</label>
              <md-input required v-model="registerForm.lastname"></md-input>
            </md-field>
            <md-field>
              <label>E-mail</label>
              <md-input type="email" required autofocus v-model="registerForm.email"></md-input>
            </md-field>
            <md-field md-has-password>
              <label>Password</label>
              <md-input required v-model="registerForm.password" type="password" md-toggle-password></md-input>
            </md-field>
            <div v-show="getLoggedUser.role === 3">
              <md-radio v-model="registerForm.role" value="1">Employee</md-radio>
              <md-radio v-model="registerForm.role" value="2">Manager</md-radio>
            </div>
            <div class="actions md-layout md-alignment-center-space-between">
              <md-button class="md-raised md-primary" type="submit">Add</md-button>
            </div>
          </form>
        </div>
      </md-content>
      <div class="background" />
    </div>
  </div>
</template>

<script>
  import store from "../_store/index.js"
  import router from "../_helpers/router"

  export default {
    store: store,
    data() {
      return {
        registerForm: {
          email: "",
          username: "",
          password: "",
          lastname: "",
          firstname: "",
          role: "1"
        }
      };
    },
    computed: {
      getRegisterStatus() {
        return this.$store.getters["userModule/getCreateStatus"]
      },
      getLoggedUser(){
        return this.$store.getters['userModule/getLoggedUser']
      }
    },
    methods: {
      register: function() {
        const {
          email,
          username,
          password,
          lastname,
          firstname,
          role
        } = this.registerForm;

        this.$store.dispatch("userModule/createUser", {
          username: username,
          email: email,
          firstname: firstname,
          lastname: lastname,
          password: password,
          role: role
        }).then(
                success => {
                  this.registerForm = {
                    email: "",
                    username: "",
                    password: "",
                    lastname: "",
                    firstname: "",
                    role: "1"
                  }
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
  .error {
    color: red;
  }
</style>
