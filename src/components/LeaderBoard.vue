<script setup>
import axios from 'axios';
import { onMounted, ref } from "vue";
const emit = defineEmits(["close"])
const closeLeaderBoard = () => {
  emit("close")
}
const users = ref([]); // Используем ref для массива пользователей


const BACKEND_URL = import.meta.env.BACKEND_URL;

onMounted(async () => {
  try {
    const response = await axios.get(`http://localhost:8001/users/get_all_by_coins`); // Используем обратные кавычки для интерполяции
    users.value = response.data; // Присваиваем данные к users.value
  } catch (error) {
    console.error("Error acquiring data:", error);
  }
});
</script>

<template>
  <div class="container">
    <div class="sub-container" >
      <div @click="closeLeaderBoard" class="close-button">
        ✖️
         <span><b>Top-20</b></span>
      </div>
      <div class="users-info">
      <div class="user-info" v-for="user in users" :key="user.id">
        <h4>Name: {{ user.username }}</h4>
        <div class="coins-number"><div class="coin-icon"></div>X{{ user.coins }}</div>
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
  font-family: "DejaVu Sans Condensed", "Rage Italic", sans-serif;
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
.users-info {
  width: 80%;
  height: 90%;
  overflow-y: auto;
  display: flex;
  flex-direction: column;
  gap: 2%;


}
.user-info {
  padding: 0.8% 6%;
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  background-image: linear-gradient(to top left, rgba(26, 255, 0, 0.45), rgba(231, 255, 22, 0.77));
  border-radius: 7%;
  border: solid 1px black;

}
.coin-icon {
  background-image: url("../assets/coin-icon.png");
  background-size: cover;
  height: 4vh;
  width: 4vh;
  border-radius: 60%;
}
.coins-number {
  font-weight: bold;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-direction: row;
}
::-webkit-scrollbar {
  width: 2vh;
  height: 90%;
}

::-webkit-scrollbar-track {
  background: #f1f1f1;
  border-radius: 5px;
}

::-webkit-scrollbar-thumb {
  background-image: linear-gradient(to right, yellow, #ff5900);
  border-radius: 5px;
  border: 1px solid #000000;

}
</style>