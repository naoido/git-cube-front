<template>
    <div width="100%" height="400px">
        <v-card
            width="100%"
            height="calc(100vh/2-25px)"
            style="max-height: 450px;"
            color="transparent"
        >   
            <v-card-title
                style="font-size: 40px; font-weight: 100; border-bottom: solid 1px white; padding-right: 160px;"
            >
                - TODOs
                <v-dialog
                    min-width="200px"
                    max-width="600px"
                    style="background-color: #000000DD !important;"
                    v-model="isDisplay"
                >
                    <template v-slot:activator="{ props }">
                        <v-icon
                            size="32"
                            v-bind="props"
                            icon="mdi mdi-cog-outline"
                        />
                    </template>
                    <v-select
                        bg-color="#222222"
                        label="Select your repository"
                        style="background-color: bg-dark-gray-4;"
                        :items="['California', 'Colorado', 'Florida', 'Georgia', 'Texas', 'Wyoming']"
                    />
                    <div style="width: 100%; display: flex; justify-content: center; align-items: center;">
                        <v-btn
                            width="100px"
                            color="success"
                            @click="apply"
                        >
                            適応
                        </v-btn>
                    </div>
                </v-dialog>
                
            </v-card-title>
            <div height="400px" width="400px" style="height: 700px;">
                <TodoModel v-for="todo in todos" 
                    :task="todo[0]"
                    :hint="todo[1]"
                />
            </div>
        </v-card>
    </div>
</template>

<script setup lang="ts">
import type { Ref } from 'vue';
import { ref } from 'vue';

const isDisplay = ref(false);
const todos: Ref<Map<String, string>> = ref(new Map());

todos.value.set("ヘルプを表示する", "printを使ってヘルプを出力しましょう")
todos.value.set("今月のグラフを作成する", "数値をデータベースから取得し、日付ごとに値を合計し、グラフに描画しましょう。")
todos.value.set("ヘルプを表示する", "printを使ってヘルプを出力しましょう")

const apply = () => {
    isDisplay.value = false;
}
</script>