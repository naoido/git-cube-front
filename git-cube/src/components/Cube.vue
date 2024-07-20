<template>
  <div>
    <canvas id="canvas"></canvas>
  </div>
</template>

<script setup lang="ts">
import * as THREE from 'three';
import { GLTFLoader } from 'three/addons/loaders/GLTFLoader.js';
import { onMounted, ref } from "vue";

const canvas = ref<HTMLCanvasElement | null>(null);

onMounted(() => {
  canvas.value = document.querySelector("canvas");

  if (!canvas.value) {
    console.error("Canvas element not found");
    return;
  }

  // シーン
  const scene = new THREE.Scene();
  scene.background = new THREE.Color("#000");

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
  camera.position.z = 1;

  // レンダラー
  const renderer = new THREE.WebGLRenderer({
    canvas: canvas.value,
    antialias: true,
    alpha: true
  });
  renderer.setSize(sizes.width, sizes.height);
  renderer.setPixelRatio(window.devicePixelRatio);

  // ボックスジオメトリー
  // const boxGeometry = new THREE.BoxGeometry(1, 1, 1);
  // const boxMaterial = new THREE.MeshStandardMaterial({
  //   color: "#7e52cc"
  // });
  // const box = new THREE.Mesh(boxGeometry, boxMaterial);
  // scene.add(box);
  const loader = new GLTFLoader();
  let cube: THREE.Object3D<THREE.Object3DEventMap>;

  loader.load('./src/models/cube.glb', function(gltf) {
    cube = gltf.scene;
    cube.scale.x = 0.5;
    cube.scale.y = 0.5;
    cube.scale.z = 0.5;
	  scene.add(cube);
  }, undefined, function (error) {
    console.error(error);
  });

  //半径
  const r = 100;
 
 //頂点数
 const starsNum = 300;
  
 //バッファーオブジェクトの生成
 const geometry = new THREE.BufferGeometry();
  
 //型付配列で頂点座標を設定
 const positions = new Float32Array(starsNum * 3);
  
 //球状に配置する頂点座標を設定
 for(let i = 0; i < starsNum; i++){
    const theta = Math.PI * Math.random();
    const phi = Math.PI * Math.random() * 2;

    positions[i * 3] = r * Math.sin(theta) * Math.cos(phi);
    positions[i * 3 + 1] = r * Math.sin(theta) * Math.sin(phi);
    positions[i * 3 + 2] = r * Math.cos(theta);
 }
  
  //バッファーオブジェクトのattributeに頂点座標を設定
  geometry.setAttribute('position',new THREE.BufferAttribute(positions,3));
    
  const material = new THREE.PointsMaterial({
    size:0.2
  });
    
  const points = new THREE.Points(geometry,material);
  scene.add(points);

  // ライト
  const ambientLight = new THREE.AmbientLight(0xffffff, 0.5);
  scene.add(ambientLight);

  const pointLight = new THREE.PointLight("#ffffff", 300);
  pointLight.position.set(5, 5, 2);

  scene.add(pointLight);

  const pointLight1 = new THREE.PointLight("#ffffff", 300);
  pointLight1.position.set(-5, 5, 0);

  scene.add(pointLight1)

  // アニメーション
  // const clock = new THREE.Clock();

  let rot = 0;
  const tick = () => {
    rot += 0.1; 
    const radian = rot * Math.PI / 180;
    // 角度に応じてカメラの位置を設定
    camera.position.x = 3 * Math.sin(radian);
    camera.position.z = 3 * Math.cos(radian);
    camera.lookAt(new THREE.Vector3(0, 0, 0));

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
