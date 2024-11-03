plugins {
    id("java")
    id("org.springframework.boot") version "3.3.5"
}

allprojects {
    group = "bot.inker.ait"
    version = "1.0-SNAPSHOT"

    repositories {
        mavenCentral()
        maven("https://repo.papermc.io/repository/maven-public/")
    }
}

dependencies {
    implementation("com.velocitypowered:velocity-proxy")
    implementation("com.velocitypowered:velocity-native")
}

springBoot {
    mainClass.set("com.bytenya.minecraft.velocityguard.VgMain")
}
