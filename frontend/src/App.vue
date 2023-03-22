<script setup>
import { ref } from "vue"
import axios from "axios"

// base64
const image = ref(null)
const outputImage = ref(null)
const loading = ref(false)

const url = "http://localhost:8082"

function onImageChoose(event) {
  outputImage.value = null
  image.value = event.target.files[0]
}

function imageFileToURL(imageFile) {
  if (typeof imageFile !== "object") {
    return imageFile;
  } else if (imageFile) {
    return URL.createObjectURL(imageFile);
  }
}

function imageFileToBase64(file) {
  return new Promise((resolve, reject) => {
    const reader = new FileReader();
    reader.onload = () => {
      resolve(reader.result);
    };
    reader.onerror = reject;
    reader.readAsDataURL(file);
  });
}

function base64toImageFile(base64Data, fileName) {
  const byteCharacters = atob(base64Data.split(',')[1]);
  const byteNumbers = new Array(byteCharacters.length);
  for (let i = 0; i < byteCharacters.length; i++) {
    byteNumbers[i] = byteCharacters.charCodeAt(i);
  }
  const byteArray = new Uint8Array(byteNumbers);
  const blob = new Blob([byteArray], { type: 'image/png' });

  return new File([blob], fileName, { type: 'image/png' });
}

async function processImageHandler() {
  let imageBase64 = await imageFileToBase64(image.value)
  loading.value = true
  let { data } = await axios.post(`${url}/process-image`, {
    "image": imageBase64,
    "name": "John",
    "surname": "Doe",
    "numbers": [1, 2, 3, 4, 5]
  })
  outputImage.value = base64toImageFile(data.processed_image, "image")
  loading.value = false
}

</script>

<template>
  <div class="flex flex-row">
    <section class="ml-5 mr-16">
      <h2 class="text-2xl mb-5">Your image</h2>
      <img v-if="image" class="my-5 rounded" width="360" :src="imageFileToURL(image)" />
      <div v-else class="my-5 rounded border border-2 border-dashed flex justify-center items-center text-slate-800"
        :style="{ width: '360px', minHeight: '360px' }">Image to display</div>
      <input type="file" accept="image/png,jpg" @change="onImageChoose($event)" />
    </section>
    <section class="flex flex-col justify-center">
      <button class="rounded-full text-white" @click="processImageHandler">
        Convert ->
      </button>
    </section>
    <section class="mr-5 ml-16">
      <h2 class="text-2xl mb-5">Output image</h2>
      <img v-if="outputImage" class="my-5 rounded" width="360" :src="imageFileToURL(outputImage)" />
      <div v-else class="my-5 rounded border border-2 border-dashed flex justify-center items-center text-slate-800"
        :style="{ width: '360px', minHeight: '360px' }">
        <div v-if="loading" class="lds-roller">
          <div></div>
          <div></div>
          <div></div>
          <div></div>
          <div></div>
          <div></div>
          <div></div>
          <div></div>
        </div>
        <div v-else>Image to display</div>
      </div>
    </section>
  </div>
</template>

<style scoped>
.logo {
  height: 6em;
  padding: 1.5em;
  will-change: filter;
  transition: filter 300ms;
}

.logo:hover {
  filter: drop-shadow(0 0 2em #646cffaa);
}

.logo.vue:hover {
  filter: drop-shadow(0 0 2em #42b883aa);
}
</style>
