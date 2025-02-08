<script setup>

import {inject, ref} from "vue";

const emit = defineEmits(['close']);
const closeProfile = () => {
  emit('close');
}
const infoBlockFlag = ref(false)

const buyBanana = async () => {
   infoBlockFlag.value = true;
   setTimeout(() => {
     infoBlockFlag.value = false;
   }, 2000);
}
</script>

<template>
  <div class="container">

    <div class="user-info">
      <span @click="closeProfile" class="close-button">
        ✖️
         <span><b/>Custom bananas</span>
      </span>

      <div class="bananas-list">
        <div class="custom-banana">
          <div>Blue banana multiplies each tap two times</div>
          <div class="banana-price">Price: 100<div class="coin-icon"></div></div>
          <div v-if="infoBlockFlag" class="info-block">Coming soon<span class="loading-dots">.</span><span class="loading-dots">.</span><span class="loading-dots">.</span></div>
          <button class="buy-button" v-else @click="buyBanana">Buy</button>
        </div>
        <div class="custom-banana">
          <div>Red banana multiplies each tap five times</div>
        <div class="banana-price">Price: 1000<div class="coin-icon"></div></div>
          <div v-if="infoBlockFlag" class="info-block">Coming soon<span class="loading-dots">.</span><span class="loading-dots">.</span><span class="loading-dots">.</span></div>
          <button class="buy-button" v-else @click="buyBanana">Buy</button>
        </div>
        <div class="custom-banana">
          <div>Emerald banana multiplies each tap ten times</div>
          <div class="banana-price">Price: 10000<div class="coin-icon"></div></div>
          <div v-if="infoBlockFlag" class="info-block">Coming soon<span class="loading-dots">.</span><span class="loading-dots">.</span><span class="loading-dots">.</span></div>
          <button class="buy-button" v-else @click="buyBanana">Buy</button>
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
.user-info {
  width: 80%;
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

.close-button {
  font-size: 3vh;
  padding: 2%;

  display: flex;
  justify-content: center;
  flex-wrap: wrap;
  gap: 10%;
  text-shadow: #ff5900 1px 1px 1px;
}

.close-button:hover {
  cursor: pointer;
  text-shadow: black 1px 1px 1px;
}
.bananas-list {
  height: 70%;
  width: 80%;
  display: flex;
  flex-direction: row;
  flex-wrap: wrap;
  align-items: center;
  justify-content: center;
  overflow-y: scroll;
  overflow-x: hidden;
}
::-webkit-scrollbar {
  width: 2vh;
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

.buy-button {
  background-image: linear-gradient(to bottom right, #5eff29, #00ffb3);
  width: 8vh;
  border-radius: 3vh;
  height: 10%;
  border: 1px solid #000000;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 60%;
  overflow: hidden;
  font-family: Jazz LET, fantasy;
}


.buy-button:hover {
  background-image: linear-gradient(to bottom, #00ffd0, #006fff);
  cursor: pointer;
  border: 2px solid black;
}

.custom-banana {
  display: flex;
  flex-direction: column;
  justify-content: space-evenly;
  align-items: center;
  width: 80%;
  height: 40%;
  margin: 3% 0;
  border: solid 1px black;
  border-radius: 12% 3% 12% 4%;
  background-size: cover;
  background-repeat: no-repeat;
  background-position: center;
  color: black;
  text-align: center;
  font-family: Jazz LET, fantasy;
  font-size: 2vh;
  overflow: hidden;
}
.loading-dots {
  animation: loading-dots 0.5s infinite;
  opacity: 0;
  display: inline-block;
}

.loading-dots:nth-child(1) {
  animation-delay: 0s;
}

.loading-dots:nth-child(2) {
  animation-delay: 0.1s;
}

.loading-dots:nth-child(3) {
  animation-delay: 0.2s;
}


@keyframes loading-dots {
  0% { opacity: 0; }
  50% { opacity: 1; }
  100% { opacity: 0; }
}
.custom-banana:nth-child(1) {
  background-image: url("../assets/blue_banana.png");


}
.custom-banana:nth-child(1):hover {
  box-shadow: #3cffff 2px 2px 2px;
}
.custom-banana:nth-child(2) {
  background-image: url("../assets/red_banana.png");


}
.custom-banana:nth-child(2):hover {
  box-shadow: red 2px 2px 2px;
}
.coin-icon {
  background-image: url("../assets/coin-icon.png");
  background-size: cover;
  height: 4vh;
  width: 4vh;
  border-radius: 60%;
}

.custom-banana:nth-child(3) {
  background-image: url("../assets/emerald_banana.png");

}
.custom-banana:nth-child(3):hover {
  box-shadow: #256a20 2px 2px 2px;
}
.banana-price {
  display: flex;
  align-items: center;
  justify-content: center;
  flex-direction: row;
}


</style>