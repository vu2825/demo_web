package com.example;

import java.util.Collections;
import java.util.LinkedList;
import java.util.List;

public class UserDB {
    private static final List<User> USERS = new LinkedList<>();

    public static synchronized void add(User u) {
        USERS.add(u);
    }

    public static List<User> all() {
        return Collections.unmodifiableList(USERS);
    }
}
