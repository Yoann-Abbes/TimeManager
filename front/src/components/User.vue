<template>
  <div class="user">
    <md-field md-inline>
      <label>User ID</label>
      <md-input v-model="$root.user.id" @keyup="getUser()"></md-input>
      <md-button class="md-icon-button" md-menu-trigger @click="createForm.showDialog = true">
        <md-icon>person_add</md-icon>
      </md-button>
    </md-field>
    <div>
      <div v-if="userChange.status === 'success'">
        <div>
          <md-card>
            <md-card-header>
              <div class="md-title">Current User</div>
            </md-card-header>

            <md-card-content>
              <div>ID: {{userChange.id}}</div>
              <div>Username: {{userChange.username}}</div>
              <div>Email: {{userChange.email}}</div>
            </md-card-content>

            <md-card-actions>
              <md-button class="md-icon-button" md-menu-trigger @click="editForm.showDialog = true">
                <md-icon>edit</md-icon>
              </md-button>
              <md-button
                class="md-icon-button"
                md-menu-trigger
                @click="deleteForm.showDialog = true"
              >
                <md-icon>delete</md-icon>
              </md-button>
              <md-menu>
                <md-button class="md-icon-button" md-menu-trigger>
                  <md-icon>more_vert</md-icon>
                </md-button>
                <md-menu-content>
                  <md-menu-item>
                    <router-link
                      :to="{name: 'workingTimes', params: {userId: userChange.id}}"
                      class="list_menu"
                    >WorkingTimes</router-link>
                  </md-menu-item>
                  <!--                                    <md-menu-item>-->
                  <!--                                        <router-link :to="{name: 'workingTime', params: {userId: userChange.id}}" class="list_menu">Create WorkingTime</router-link>-->
                  <!--                                    </md-menu-item>-->
                  <!--                                    <md-menu-item>-->
                  <!--                                        <router-link :to="{name: 'workingTime', params: {userId: userChange.id, workingtimeId: 1}}" class="list_menu">Edit WorkingTime</router-link>-->
                  <!--                                    </md-menu-item>-->
                  <md-menu-item>
                    <router-link
                      :to="{name: 'clockManager', params: {username: userChange.username}}"
                      class="list_menu"
                    >ClockManager</router-link>
                  </md-menu-item>
                  <md-menu-item>
                    <router-link
                      :to="{name: 'chartManager', params: {userId: userChange.id}}"
                      class="list_menu"
                    >ChartManager</router-link>
                  </md-menu-item>
                </md-menu-content>
              </md-menu>
            </md-card-actions>
          </md-card>
        </div>
      </div>
      <div v-else>No user found.</div>
    </div>
    <!-- create user form -->
    <md-dialog :md-active.sync="createForm.showDialog">
      <p v-if="errors.length">
        <b>Please correct the following error(s):</b>
        <br />
        {{ errors }}
      </p>

      <md-dialog-title>Create a user</md-dialog-title>
      <md-dialog-content>
        <md-field>
          <label>Username</label>
          <md-input v-model="createForm.username"></md-input>
        </md-field>
        <md-field>
          <label>Email</label>
          <md-input v-model="createForm.email" type="email"></md-input>
        </md-field>
      </md-dialog-content>
      <md-dialog-actions>
        <md-button class="md-danger" @click="createForm.showDialog = false">Close</md-button>
        <md-button class="md-primary" @click="createUser">Create</md-button>
      </md-dialog-actions>
    </md-dialog>
    <!-- fin de create user form -->
    <!-- edit user form -->
    <md-dialog :md-active.sync="editForm.showDialog">
      <md-dialog-title>Edit a user</md-dialog-title>
      <md-dialog-content>
        <md-field>
          <label>Username</label>
          <md-input v-model="editForm.username" :value="$root.user.username">{{$root.user.username}}</md-input>
        </md-field>
        <md-field>
          <label>Email</label>
          <md-input v-model="editForm.email" :value="$root.user.username"></md-input>
        </md-field>
      </md-dialog-content>
      <md-dialog-actions>
        <md-button class="md-danger" @click="editForm.showDialog = false">Close</md-button>
        <md-button class="md-primary" @click="updateUser">Create</md-button>
      </md-dialog-actions>
    </md-dialog>
    <!-- fin de edit user form -->
    <!-- delete user form -->
    <md-dialog :md-active.sync="deleteForm.showDialog">
      <md-dialog-title>Delete a user</md-dialog-title>
      <md-dialog-content>
        <span>This user will be deleted ... Are you sure ?</span>
      </md-dialog-content>
      <md-dialog-actions>
        <md-button class="md-danger" @click="deleteForm.showDialog = false">No</md-button>
        <md-button class="md-primary" @click="deleteUser">Yes</md-button>
      </md-dialog-actions>
    </md-dialog>
    <!-- fin de delete user form -->
  </div>
</template>

<script>
import { userService } from "../_services/user.service";

export default {
  data() {
    return {
      errors: "",
      createForm: {
        showDialog: false,
        username: "",
        email: ""
      },
      editForm: {
        showDialog: false,
        username: "",
        email: ""
      },
      deleteForm: {
        showDialog: false
      }
    };
  },
  computed: {
    userChange() {
      return this.$root.getCurrentUser;
    }
  },
  methods: {
    createUser: function() {
      const { username, email } = this.createForm;
      console.log("TEST");
      this.errors = "";
      if (!username) this.errors += "Username required.";
      else this.errors = "";
      if (!email || !this.validEmail(email))
        this.errors += " Valid email required.";
      if (!this.errors.length)
        userService.createUser(username, email).then(
          success => {
            this.createForm.showDialog = false;
            console.log(success);
          },
          error => {
            console.log(error);
          }
        );
    },
    validEmail: function(email) {
      var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
      console.error(re.test(email));
      return re.test(email);
    },
    updateUser: function() {
      const { username, email } = this.editForm;
      userService.updateUser(this.$root.user.id, username, email).then(
        success => {
          this.$root.changeUser(success.data.data);
          this.editForm.showDialog = false;
        },
        error => {
          console.log(error);
        }
      );
    },
    getUser: function() {
      if (this.$route.name !== "home") {
        this.$router.push("/");
      }
      userService.getUser(this.$root.user.id).then(
        success => {
          this.$root.changeUser(success.data.data);
          this.editForm.username = this.$root.user.username;
          this.editForm.email = this.$root.user.email;
        },
        error => {
          this.$root.changeUser();
        }
      );
    },
    deleteUser: function() {
      userService.deleteUser(this.$root.user.id).then(
        success => {
          this.$root.changeUser();
          this.deleteForm.showDialog = false;
        },
        error => {
          console.log(error);
        }
      );
    }
  }
};
</script>