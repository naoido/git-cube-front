<template>
  <div>
    <canvas id="canvas"></canvas>
  </div>
</template>

<script setup lang="ts">
import { onMounted, ref } from "vue";
import * as THREE from 'three'

const canvas = ref<HTMLCanvasElement | null>(null);

onMounted(() => {
  canvas.value = document.querySelector("canvas");

  if (!canvas.value) {
    console.error("Canvas element not found");
    return;
  }

  // シーン
  const scene = new THREE.Scene();
  scene.background = new THREE.Color("#2f2f2f2");

  // サイズ
  const sizes = {
    width: window.innerWidth,
    height: window.innerHeight
  };

  // カメラ
  const camera = new THREE.PerspectiveCamera(
    75,
    sizes.width / sizes.height,
    0.1,
    1000
  );
  camera.position.z = 2;

  // レンダラー
  const renderer = new THREE.WebGLRenderer({
    canvas: canvas.value,
    antialias: true,
    alpha: true
  });
  renderer.setSize(sizes.width, sizes.height);
  renderer.setPixelRatio(window.devicePixelRatio);

  // ボックスジオメトリー
  const boxGeometry = new THREE.BoxGeometry(1, 1, 1);
  const boxMaterial = new THREE.MeshLambertMaterial({
    color: '#ffffff'
  });
  const box = new THREE.Mesh(boxGeometry, boxMaterial);
  scene.add(box);

  // ライト
  const ambientLight = new THREE.AmbientLight(0xffffff, 0.3);
  scene.add(ambientLight);
  const pointLight = new THREE.PointLight(0xffffff, 500);
  pointLight.position.set(5, 13, 5);
  scene.add(pointLight);

  // アニメーション
  const clock = new THREE.Clock();
  const tick = () => {
    const elapsedTime = clock.getElapsedTime();
    box.rotation.x = elapsedTime;
    box.rotation.y = elapsedTime;
    renderer.render(scene, camera);
    window.requestAnimationFrame(tick);
  };
  tick();

  // ブラウザのリサイズ処理
  window.addEventListener('resize', () => {
    sizes.width = window.innerWidth;
    sizes.height = window.innerHeight;
    camera.aspect = sizes.width / sizes.height;
    camera.updateProjectionMatrix();
    renderer.setSize(sizes.width, sizes.height);
    renderer.setPixelRatio(window.devicePixelRatio);
  });
});
</script>
