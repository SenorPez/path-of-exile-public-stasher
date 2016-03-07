"""
Provides a class for Path of Exile items.
"""

class Item:
    """
    A class representing a path of exile item.
    """
    def __init__(self, item, stash, parent_id=None):
        self.table_name = "items"
        self.item_id = item['id']
        self.parent_id = parent_id

        self.stash = stash
        self.stash_id = stash.stash_id
        self.database = stash.database

        self._database_worker(item)

    def _database_worker(self, item_data):
        item_properties = {key:value for key, value \
                           in item_data.items() \
                           if not isinstance(value, list)}
        item_properties['stashTabID'] = self.stash_id

        if self.parent_id is not None:
            item_properties['parentID'] = self.parent_id

        query_fields = "(`{0}`)".format("`, `".join(
            [key for key in item_properties.keys()]))
        query_values = tuple(item_properties.values())
        query_items = ", ".join(
            ["`"+key+"`=%s" for key in item_properties.keys()])

        query_string = "INSERT INTO `"+self.table_name+"` " + \
            query_fields + \
            "VALUES ("+",".join(
                ["%s" for _ in range(len(item_properties))])+") " + \
            "ON DUPLICATE KEY UPDATE "+query_items

        self.database.query(query_string, query_values+query_values)

        try:
            item_note = item_data['note']
        except KeyError:
            pass
        else:
            query_string = "SELECT `note` FROM `itemNotes` " + \
                           "WHERE `id` = %s " + \
                           "ORDER BY `noteDate` DESC " + \
                           "LIMIT 1"
            query_values = (item_data['id'],)

            last_note = self.database.query(
                query_string,
                query_values).fetchone()

            if last_note is None or \
                    last_note[0] != item_note:
                query_string = "INSERT INTO `itemNotes` " + \
                               "(`id`, `note`) " + \
                               "VALUES (%s, %s)"
                query_values = (item_data['id'], item_data['note'])
                self.database.query(query_string, query_values)

        _ = [self._dispatcher(key, value) for key, value \
            in item_data.items() if isinstance(value, list)]

    def _dispatcher(self, key, value):
        try:
            if key == "sockets":
                self.__add_sockets(value)
            elif key == "properties":
                self.__add_properties(value)
            elif key == "additionalProperties":
                self.__add_additional_properties(value)
            elif key == "requirements":
                self.__add_requirements(value)
            elif key == "nextLevelRequirements":
                self.__add_nl_requirements(value)
            elif key == "flavourText":
                self.__add_flavour_text(value)
            elif key == "explicitMods":
                self.__add_explicit_mods(value)
            elif key == "implicitMods":
                self.__add_implicit_mods(value)
            elif key == "craftedMods":
                self.__add_crafted_mods(value)
            elif key == "cosmeticMods":
                self.__add_cosmetic_mods(value)
            elif key == "socketedItems":
                if len(value):
                    for item in value:
                        _ = Item(item, self.stash, self.parent_id)
            else:
                raise ValueError("Unknown key: {}".format(key))
        except ValueError:
            raise

    def __add_sockets(self, value):
        for socket_data in value:
            socket_properties = {key:value for key, value \
                in socket_data.items()}
            socket_properties['itemID'] = self.item_id

            query_fields = "(`{0}`)".format("`, `".join(
                [key for key in socket_properties.keys()]))
            query_values = tuple(socket_properties.values())

            query_string = "INSERT INTO `sockets`" + \
                query_fields + \
                "VALUES ("+",".join(
                    ["%s" for _ in range(len(socket_properties))])+")"

            self.database.query(query_string, query_values)

    def __add_properties(self, value):
        for property_data in value:
            property_properties = {key:value for key, value \
                in property_data.items() \
                if not isinstance(value, list)}
            property_properties['itemID'] = self.item_id

            query_fields = "(`{0}`)".format("`, `".join(
                [key for key in property_properties.keys()]))
            query_values = tuple(property_properties.values())

            query_string = "INSERT INTO `properties`" + \
                query_fields + \
                "VALUES ("+",".join(
                    ["%s" for _ in range(len(property_properties))])+")"

            self.database.query(query_string, query_values)
            property_id = self.database.last_insert_id

            _ = [self.__add_property_values(property_id, value) \
                for key, value \
                in property_data.items() if isinstance(value, list)]

    def __add_property_values(self, property_id, value):
        for values in value:
            for property_data in values:
                query_fields = "(`{0}`)".format("`, `".join(
                    ['propertyID', 'value']))
                query_values = (property_id, property_data)

                query_string = "INSERT INTO `propertiesValues`" + \
                    query_fields + \
                    "VALUES ("+",".join(
                        ["%s" for _ in range(len(query_values))])+")"
                self.database.query(query_string, query_values)

    def __add_additional_properties(self, value):
        for property_data in value:
            property_properties = {key:value for key, value \
                in property_data.items() \
                if not isinstance(value, list)}
            property_properties['itemID'] = self.item_id

            query_fields = "(`{0}`)".format("`, `".join(
                [key for key in property_properties.keys()]))
            query_values = tuple(property_properties.values())

            query_string = "INSERT INTO `additionalProperties`" + \
                query_fields + \
                "VALUES ("+",".join(
                    ["%s" for _ in range(len(property_properties))])+")"

            self.database.query(query_string, query_values)
            property_id = self.database.last_insert_id

            _ = [self.__add_additional_property_values(
                property_id,
                value) for key, value \
                in property_data.items() if isinstance(value, list)]

    def __add_additional_property_values(self, property_id, value):
        for values in value:
            for property_data in values:
                query_fields = "(`{0}`)".format("`, `".join(
                    ['additionalPropertyID', 'value']))
                query_values = (property_id, property_data)

                query_string = "INSERT INTO " + \
                    "`additionalPropertiesValues`" + \
                    query_fields + \
                    "VALUES ("+",".join(
                        ["%s" for _ in range(len(query_values))])+")"
                self.database.query(query_string, query_values)

    def __add_requirements(self, value):
        for requirements_data in value:
            requirements_properties = {key:value for key, value \
                in requirements_data.items() \
                if not isinstance(value, list)}
            requirements_properties['itemID'] = self.item_id

            query_fields = "(`{0}`)".format("`, `".join(
                [key for key in requirements_properties.keys()]))
            query_values = tuple(requirements_properties.values())

            query_string = "INSERT INTO `requirements`" + \
                query_fields + \
                "VALUES ("+",".join(
                    ["%s" for _ in range(
                        len(requirements_properties))])+")"

            self.database.query(query_string, query_values)
            requirements_id = self.database.last_insert_id

            _ = [self.__add_requirements_values(
                requirements_id, value) for key, value \
                in requirements_data.items() if isinstance(value, list)]

    def __add_requirements_values(self, requirements_id, value):
        for values in value:
            for requirements_data in values:
                query_fields = "(`{0}`)".format("`, `".join(
                    ['requirementID', 'value']))
                query_values = (requirements_id, requirements_data)

                query_string = "INSERT INTO `requirementsValues`" + \
                    query_fields + \
                    "VALUES ("+",".join(
                        ["%s" for _ in range(len(query_values))])+")"
                self.database.query(query_string, query_values)

    def __add_nl_requirements(self, value):
        for nl_requirements_data in value:
            nl_requirements_properties = {key:value for key, value \
                in nl_requirements_data.items() \
                if not isinstance(value, list)}
            nl_requirements_properties['itemID'] = self.item_id

            query_fields = "(`{0}`)".format("`, `".join(
                [key for key in nl_requirements_properties.keys()]))
            query_values = tuple(nl_requirements_properties.values())

            query_string = "INSERT INTO `nextLevelRequirements`" + \
                query_fields + \
                "VALUES ("+",".join(
                    ["%s" for _ in range(
                        len(nl_requirements_properties))])+")"

            self.database.query(query_string, query_values)
            nl_requirements_id = self.database.last_insert_id

            _ = [self.__add_nl_requirements_values(
                nl_requirements_id, value) for key, value \
                in nl_requirements_data.items() \
                if isinstance(value, list)]

    def __add_nl_requirements_values(self, nl_requirements_id, value):
        for values in value:
            for nl_requirements_data in values:
                query_fields = "(`{0}`)".format("`, `".join(
                    ['nextLevelRequirementID', 'value']))
                query_values = (
                    nl_requirements_id,
                    nl_requirements_data)

                query_string = "INSERT INTO " + \
                    "`nextLevelRequirementsValues`" + \
                    query_fields + \
                    "VALUES ("+",".join(
                        ["%s" for _ in range(len(query_values))])+")"
                self.database.query(query_string, query_values)

    def __add_flavour_text(self, value):
        for flavour_text in value:
            query_string = "INSERT INTO `flavourText` " + \
                "(`itemID`, `flavourText`) " + \
                "VALUES (%s, %s)"
            self.database.query(
                query_string,
                (self.item_id, flavour_text))

    def __add_explicit_mods(self, value):
        for explicit_mod in value:
            query_string = "INSERT INTO `explicitMods` " + \
                "(`itemID`, `explicitMod`) " + \
                "VALUES (%s, %s)"
            self.database.query(
                query_string,
                (self.item_id, explicit_mod))

    def __add_implicit_mods(self, value):
        for implicit_mod in value:
            query_string = "INSERT INTO `implicitMods` " + \
                "(`itemID`, `implicitMod`) " + \
                "VALUES (%s, %s)"
            self.database.query(
                query_string,
                (self.item_id, implicit_mod))

    def __add_crafted_mods(self, value):
        for crafted_mod in value:
            query_string = "INSERT INTO `craftedMods` " + \
                "(`itemID`, `craftedMod`) " + \
                "VALUES (%s, %s)"
            self.database.query(
                query_string,
                (self.item_id, crafted_mod))

    def __add_cosmetic_mods(self, value):
        for cosmetic_mod in value:
            query_string = "INSERT INTO `cosmeticMods` " + \
                "(`itemID`, `cosmeticMod`) " + \
                "VALUES (%s, %s)"
            self.database.query(
                query_string,
                (self.item_id, cosmetic_mod))
