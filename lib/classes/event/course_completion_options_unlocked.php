<?php
// This file is part of Moodle - http://moodle.org/
//
// Moodle is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// Moodle is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with Moodle.  If not, see <http://www.gnu.org/licenses/>.

/**
 * Course completion options unlocked event.
 *
 * @package    core
 * @copyright  2022 Matt Rice <matt.rice@moodle.com>
 * @license    http://www.gnu.org/copyleft/gpl.html GNU GPL v3 or later
 */

namespace core\event;

/**
 * Course completion options unlocked event class.
 *
 * @package    core
 * @since      Moodle 3.11
 * @copyright  2022 Matt Rice <matt.rice@moodle.com>
 * @license    http://www.gnu.org/copyleft/gpl.html GNU GPL v3 or later
 */
class course_completion_options_unlocked extends base {

    /**
     * Initialise required event data properties.
     */
    protected function init() {
        $this->data['crud'] = 'u';
        $this->data['edulevel'] = self::LEVEL_TEACHING;
    }

    /**
     * Returns localised event name.
     *
     * @return string
     */
    public static function get_name() {
        return get_string('eventcoursecompletionoptionsunlocked', 'core_completion');
    }

    /**
     * Returns localised event description with id's for admin use only.
     *
     * @return string
     */
    public function get_description() {
        return get_string('eventcoursecompletionoptionsunlockeddesc', 'core_completion', array(
            'userid'   => $this->userid,
            'courseid' => $this->courseid
        ));
    }

    /**
     * Returns relevant URL.
     *
     * @return \moodle_url
     */
    public function get_url() {
        return new \moodle_url('/course/completion.php', array('id' => $this->courseid));
    }

    /**
     * Return legacy add_to_log() data.
     *
     * @return array of parameters to be passed to legacy add_to_log() function.
     */
    protected function get_legacy_logdata() {
        return array($this->courseid, 'course', 'completion options unlocked', 'completion.php?id=' . $this->courseid);
    }
}
