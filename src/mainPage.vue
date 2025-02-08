<script setup>
import {ref, computed, onMounted, provide} from 'vue'
import Profile from "./components/Profile.vue";
import LeaderBoard from "./components/LeaderBoard.vue";
import Tasks from "./components/Tasks.vue";
import axios from 'axios'

defineProps({
  msg: String,
})

const BACKEND_URL = import.meta.env.VITE_BACKEND_URL;

const isJumping = ref(false)
const count = ref(0)
const progressPercentage = computed(() => (count.value / 100) * 100)
const coins = ref(0);
const showProfile = ref(false);
const showLeaderBoard = ref(false)
const showTasks = ref(false);
const userName = ref(null);
const loading = ref(false);
const error = ref(null);
const telegramUserId = ref(null);


onMounted(() => {
  getTelegramUserId();
});

const getTelegramUserId = () => {
  let telegramIdStr;

  // Пробуем получить telegramId из параметров запроса
  const urlParams = new URLSearchParams(window.location.search);
  telegramIdStr = urlParams.get('telegramId');

  // Если не нашли в параметрах запроса, пробуем получить из фрагмента URL
  if (!telegramIdStr) {
    const hash = window.location.hash.substring(1); // Убираем #
    if (hash) {
      try {
        const hashParams = new URLSearchParams(hash);
        telegramIdStr = hashParams.get('telegramId');
      } catch (error) {
        console.error('Error parsing hash:', error);
        error.value = "Ошибка парсинга данных из фрагмента URL";
        return; // Выходим, если произошла ошибка парсинга
      }
    }
  }

  if (telegramIdStr) {
    const telegramIdNum = parseInt(telegramIdStr, 10);
    if (!isNaN(telegramIdNum)) {
      telegramUserId.value = telegramIdNum;
      fetchUserName();
    } else {
      error.value = "Неверный telegramId";
    }
  } else {
    error.value = "telegramId не найден";
  }
};

const fetchUserName = async () => {
  if (telegramUserId.value !== null) {
    loading.value = true;
    error.value = null;
    try {
      provide('telegramUserId', telegramUserId.value); // обеспечиваем все дочерние модули этой переменной
      const response = await axios.get(`${BACKEND_URL}/users/get_user/${telegramUserId.value}`);
      userName.value = response.data.username || 'Guest';
      coins.value = response.data.coins || 0;
    } catch (error) {
      error.value = "Ошибка получения данных пользователя";
    } finally {
      loading.value = false;
    }
  }
};


const handleClick = async () => {
  count.value++
  isJumping.value = true;
  setTimeout(() => {
    isJumping.value = false;
  }, 300);
  if (count.value % 100 === 0) {
    const response = await axios.patch(`${BACKEND_URL}/users/increment-coins/${telegramUserId.value}`);
    coins.value = response.data;
    provide('coins', coins.value);
    count.value = 0;
  }
}
const toggleModal = (modal) => {
  if (modal === 'profile') {
    showProfile.value = true;
  }
  if (modal === 'leaderboard') {
    showLeaderBoard.value = true;
  }
  if (modal === 'tasks') {
    showTasks.value = true;
  }
}
</script>

<template>
  <div class="container">
    <Tasks  v-if="showTasks" @close="() => showTasks = false"/>
    <Profile v-if="showProfile" @close="() => showProfile = false" />
    <LeaderBoard v-if="showLeaderBoard" @close="() => showLeaderBoard = false" />
    <header class="header">
      <div class="main-element">
        ❔
        <div class="app-hint">Tap the button to enlarge the score (100 scores = 1 coin)</div>
      </div>
      <h1 v-if="loading">Loading...</h1>
      <div v-else-if="error">{{ error }}</div>
      <div v-else>
        <h1>Welcome, {{ userName }}!</h1>
      </div>
    </header>
    <div class="main-button-div">
      <div class="coins-bar">
        <div class="coins-number" v-if="coins> 0">{{coins}}<div class="coin-icon"></div></div>
        <div class="progress-bar"><div class="progress-bar-fill" :style="{ width: progressPercentage + '%'}"></div></div>
      </div>
      <div class="counter-result">
        <div>{{ count }}</div>
      </div>
    <button type="button" class="main-button" @click="handleClick" :class="{ jump: isJumping}"></button>
    </div>
    <footer class="footer">
      <i @click="() => toggleModal('profile')" class="fa-regular fa-address-card"></i>
      <i @click="() => toggleModal('leaderboard')" class="fa-solid fa-trophy"></i>
      <i @click="() => toggleModal('tasks')" class="fa-solid fa-list-check"></i>
    </footer>
  </div>

</template>

<style scoped>
.container {
  font-family: OCR A Std, monospace;
  display: flex;
  flex-direction: column;
  align-items: center;
  height: 100%;

}
.main-button-div {
  position: fixed;
  top: 40%;
  width: 100%;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  gap: 1rem;
}
.header {
  position: fixed;
  top: 3vh;
  padding: 2%;
  gap: 7%;
  width: 80%;
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: center;
  height: 5vh;
  font-size: 2vh;
  background-image: linear-gradient(to bottom left, #ffd403, #ff8000);
  border-radius: 10vh;
}
.main-element {
  font-size: 2.5vh;
  position: relative;
}

.app-hint {
  position: absolute;
  background-image: linear-gradient(to top, #e0ffb1, rgba(34, 28, 28, 0.78));
  border-radius: 5px;
  border: 1px solid #000000;
  top: 160%;
  opacity: 0;
  width: 30vh;
  font-size: 2vh;
  transition: opacity 0.3s ease;
  pointer-events: none;
}

.main-element:hover .app-hint {
  opacity: 1;
}
.progress-bar {
  width: 70%;
  height: 4vh;
  background-color: #ddd;
  border-radius: 2vh;
  overflow: hidden;
}

.progress-bar-fill {
  height: 100%;
  background-color: #4CAF50;
  border-radius: 10px;
}


.counter-result {
  display: flex;
  flex-direction: column;
  align-items: center;
  font-size: 4vh;
  color: white;
}
.coin-icon {
  background-image: url("assets/coin-icon.png");
  background-size: cover;
  height: 5vh;
  width: 5vh;
  border-radius: 60%;
}

.coins-bar {
  display: flex;
  flex-direction: row;
  justify-content: center;
  gap: 3vh;
  width: 100%;
}
.coins-number {
  display: flex;
  flex-direction: row;
  gap: 0.5vh;
  font-size: 4vh;
  color: white;
}
.main-button {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  background-image: url("assets/firstBanana.png");
  font-size: 2vh;
  height: 18vh;
  width: 18vh;
  border-radius: 9vh;
  border: solid 1px black;
  background-size: contain;
  background-position: center;
  margin: auto;
}

.main-button.jump {
  animation: jump 0.3s ease-in-out;
}

@keyframes jump {
  0% { transform: translateY(0); }
  25% { transform: translateY(-10px); }
  50% { transform: translateY(0); }
  75% { transform: translateY(-5px); }
  100% { transform: translateY(0); }
}

.footer {
  position: fixed;
  bottom: 3vh;
  padding: 2%;
  width: 80%;
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: center;
  gap: 10vh;
  height: 5vh;
  background-image: linear-gradient(to bottom left, #ffd403, #ff8000);
  border-radius: 10vh;
}

.footer i {
  font-size: 3.6vh;
  margin: 0 2.5%;
}
.footer i:hover {
  font-size: 4.3vh;
}
</style>