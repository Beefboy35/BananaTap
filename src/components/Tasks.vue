<script setup>

import {computed, inject, onMounted, ref} from 'vue';
import axios from "axios";


const emit = defineEmits(["close"]);
const closeTasks = () => {
  emit("close");
};
const BACKEND_URL = import.meta.env.VITE_BACKEND_URL;
const isHundredEarned = ref(false)
const isThousandEarned = ref(false)
const isTenThousandEarned = ref(false)
const Error = ref(false)
const ErrorDescription = ref("");
const telegramUserId = inject('telegramUserId'); // забираем telegramID из mainPage.vue
onMounted( async () => {
  const response = await axios.get(`${BACKEND_URL}/users/get_user/${telegramUserId}`, {});
  if (response.status === 200) {
    if (response.data.coins >= 100) {
      isHundredEarned.value = true;
    }
    if (response.data.coins >= 1000) {
      isThousandEarned.value = true;
    }
    if (response.data.coins >= 10000) {
      isTenThousandEarned.value = true;
    }
  } else {
    ErrorDescription.value = response.data.message;
  }
})



</script>

<template>
  <div class="container">
    <div v-if="Error"> {{ErrorDescription}}</div>
    <div class="sub-container" >
      <div @click="closeTasks" class="close-button">
        ✖️
        <span><b>Tasks</b></span>
      </div>
      <div class="users-tasks">
        <div class="task">
              <h4>Earn your first hundred coins </h4>
            <p v-if="isHundredEarned">✅Completed</p>
            <p v-else>❌Not completed, be on it!</p>
        </div>
        <div class="task">
          <h4>Earn thousand coins</h4>

          <p v-if="isThousandEarned">✅Completed</p>
          <p v-else>❌Not completed, be on it!</p>
        </div>
        <div class="task">
          <h4>Earn ten thousand coins</h4>

          <p v-if="isTenThousandEarned">✅Completed</p>
          <p v-else>❌Not completed, be on it!</p>
        </div>
      </div>
    </div>
  </div>
</template>
<style scoped>
.container {
  width: 100%;
  height: 100vh;
  background: rgba(0, 0, 0, 0.4);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 1;

}
.close-button {
  width: 70%;
  text-align: center;
}

.close-button:hover {
  cursor: pointer;
}
.sub-container {
  width: 70%;
  height: 60%;
  border: solid 1px black;
  border-radius: 7%;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 3%;
  padding: 3%;
  background-image: linear-gradient(to bottom right, #fdf32e, #df5705);
}
.users-tasks {
  width: 80%;
  height: 90%;
  overflow-y: auto;
  display: flex;
  justify-content: center;
  flex-direction: column;
  gap: 2%;


}
.task {
  padding: 0 2%;
  display: grid;
  grid-template-columns: 1fr 0.5fr;
  justify-content: space-between;
  background-image: linear-gradient(to top left, rgba(26, 255, 0, 0.45), rgba(231, 255, 22, 0.77));
  border-radius: 7%;
  border: solid 1px black;

}

</style>