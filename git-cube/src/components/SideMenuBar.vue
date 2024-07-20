<template>
    <div id="menu">
        <ul>
            <li v-for="(link, index) in links">
                <router-link
                    :to="link.path"
                    active-class="active"
                >
                    {{ link.name }}
                </router-link>
            </li>
        </ul>
    </div>
</template>

<script setup lang="ts">
const links = [
    {
        name: "Home",
        path: "/"
    },
    {
        name: "Mypage",
        path: "/home"
    },
    {
        name: "Settings",
        path: "/settings"
    }
]
</script>

<style lang="scss">
#menu {
    height: 100vh;
    width: 500px;
    display: flex;
    justify-content: left;
    padding-left: 80px;
    align-items: center;
    ul {
        list-style: none;
        width: max-content;
        li {
            color: #303030;
            font-size: 40px;
            text-decoration: none;
            display: flex;
            flex-wrap: none;
            flex-direction: row;
            justify-content: center;
            align-items: center;
            margin: 5px 0;
            width: 200px;
            a {
                text-decoration: none;
                color: #e3e3e3;
                transition: opacity 0.3s ease;
                transition: width 0.3s ease;
                opacity: 1;
                width: 100%;
                &::before {
                    content: "";
                    position: relative;
                    top: -5px;
                    display: inline-block;
                    height: calc(20px / 2 * tan(60deg));
                    width: 20px;
                    clip-path: polygon(0 0, 100% 50%, 0 100%);
                    margin-right: 15px;
                    background-color: #e3e3e3;
                    opacity: 0;
                    transition: all 0.3s ease;
                    transform: translateX(-10px);
                }
                &::after {
                    content: "";
                    display: block;
                    height: 1px;
                    width: 0%;
                    background-color: #e3e3e3;
                    transition: all 0.3s ease;
                }
                &:hover {
                    opacity: 0.7;
                    &::after {
                        width: 100%;
                    }
                }
            }
            .active {
                color: #82e276;
                &::before {
                    opacity: 1;
                    transform: translateX(0);
                }
            }
        }
    }
}
</style>