#include <iostream>
#include <cstdlib>
#include <unistd.h>

bool is_waybar_running() {
    return system("pgrep -x waybar > /dev/null") == 0;
}

void kill_waybar() {
    std::cout << "Waybar já está rodando. Reiniciando..." << std::endl;
    system("pkill -x waybar");
    sleep(1);
}

int main() {
    if (is_waybar_running()) {
        kill_waybar();
    }

    std::cout << "Iniciando Waybar..." << std::endl;
    system("waybar > ~/.local/share/waybar.log 2>&1 &");

    return 0;
}

